#include <QFile>
#include <QTextStream>
#include "configuration.h"

Configuration::Configuration()
{
    std::string m_configPath;
    std::string m_name;
    std::string m_githubUrl;
    std::string m_linkedinUrl;
    std::string m_email;

}

Configuration::Configuration(const std::string& path): Configuration()
{
    this->configPath = path;
}

Configuration::~Configuration()
{
}

void Configuration::Unload()
{
    this->m_name = "";
    this->m_githubUrl = "";
    this->m_linkedinUrl = "";
    this->m_email = "";
}

std::map<std::string, std::string> Configuration::Load()
{
    if (this->configPath == "")
    {
        throw std::invalid_argument("Configuration file must be set before loading one");
    }

    std::map<std::string, std::string> config = this->Load(this->configPath);

    this->m_name = config["name"];
    this->m_githubUrl = config["github"];
    this->m_linkedinUrl = config["linkedin"];
    this->m_email = config["email"];

    return config;
}

std::map<std::string, std::string> Configuration::Load(const std::string& path)
{
    QFile file(QString::fromStdString(path));
    if (!file.open(QIODevice::ReadOnly))
    {
        throw std::invalid_argument("Error at opening configuration file for read");
    }

    std::map<std::string, std::string> configuration;
    const std::string configSeparator = "=";
    std::string line;

    QTextStream fileStream(&file);
    while (!fileStream.atEnd())
    {
        line = fileStream.readLine().toStdString();
        int separatorIdx = line.find(configSeparator);
        std::string configVariable = line.substr(0, separatorIdx);
        std::string variableValue = line.substr(separatorIdx + 1, line.size());

        configuration[configVariable] = variableValue;
    }

    return configuration;
}

void Configuration::Save()
{
    if (this->configPath == "")
    {
        // Configuration file not set, nowhere to write data
        return;
    }

    this->Save(this->configPath);
}

void Configuration::Save(const std::string& path)
{
    QFile file(QString::fromStdString(path));
    if (!file.open(QIODevice::WriteOnly))
    {
        throw std::invalid_argument("Error at opening configuration file for write");
    }

    QTextStream fileStream(&file);

    fileStream << "name=" + this->name() << "\n";
    fileStream << "github=" + this->githubUrl() << "\n";
    fileStream << "linkedin=" + this->linkedinUrl() << "\n";
    fileStream << "email=" + this->email() << "\n";
}
