#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <string>
#include <map>

/**
 * @brief A class handling configuration files and their contents.
 *
 */
class Configuration: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString githubUrl READ githubUrl WRITE setGithubUrl NOTIFY githubUrlChanged)
    Q_PROPERTY(QString linkedinUrl READ linkedinUrl WRITE setLinkedinUrl NOTIFY linkedinUrlChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)

    public:
        /**
         * @brief Construct a new configuration file handler.
         *
         *
         */
        Configuration();

        /**
         * @brief Construct a new configuration file handler with predefined filepath.
         *
         * @param path Path to a configuration file.
         */
        Configuration(const std::string& path);

        /**
         * @brief Destroy a configuration file handler.
         *
         */
        ~Configuration();

        /**
         * @brief Unload configuration file contents from memory.
         * Does not reset the configuration file path.
         *
         */
        Q_INVOKABLE void Unload();

        /**
         * @brief Load a configuration file into memory. A filepath must be defined before calling this method.
         *
         * @return std::map<std:: string, std::string> Configuration file contents in a map
         * @throws std::invalid_argument The configuration file path does not point to an existing file.
         */
        Q_INVOKABLE std::map<std:: string, std::string> Load();

        /**
         * @brief Load a configuration file in given path into memory.
         *
         * @param path Path to the configuration file.
         * @return std::map<std:: string, std::string> Configuration file contents in a map
         * @throws std::invalid_argument The configuration file path does not point to an existing file.
         */
        Q_INVOKABLE static std::map<std:: string, std::string> Load(const std::string& path);

        /**
         * @brief Save configuration contents into a file. Configuration file path must be defined before calling this method.
         *
         * @throws std::invalid_argument A file at configuration file path could not be opened.
         */
        Q_INVOKABLE void Save();

        /**
         * @brief Save configuration contents into a file in given location.
         *
         * @param path Path to the configuration file.
         * @throws std::invalid_argument A file at given path could not be opened.
         */
        Q_INVOKABLE void Save(const std::string& path);

        /**
         * @brief Path to a configuration file.
         *
         */
        std::string configPath;

        // Variables in configuration files

        std::string m_name;
        std::string m_githubUrl;
        std::string m_linkedinUrl;
        std::string m_email;

        // Property getters and setters

        QString name() const
        {
            return QString::fromUtf8(this->m_name);
        }

        void setName(const QString& name)
        {
            this->m_name = name.toStdString();
            emit this->nameChanged();
        }

        QString githubUrl() const
        {
            return QString::fromUtf8(this->m_githubUrl);
        }

        void setGithubUrl(const QString& url)
        {
            this->m_name = url.toStdString();
            emit this->githubUrlChanged();
        }

        QString linkedinUrl() const
        {
            return QString::fromUtf8(this->m_linkedinUrl);
        }

        void setLinkedinUrl(const QString& url)
        {
            this->m_name = url.toStdString();
            emit this->linkedinUrlChanged();
        }

        QString email() const
        {
            return QString::fromUtf8(this->m_email);
        }

        void setEmail(const QString& email)
        {
            this->m_name = email.toStdString();
            emit this->emailChanged();
        }

    signals:
        void nameChanged();
        void githubUrlChanged();
        void linkedinUrlChanged();
        void emailChanged();
};

#endif
