# Keycloak authentication
[Keycloak](https://www.keycloak.org/) is Open Source Identity and Access Management solution that provide a set of administrative UIs and API to implement authentication and authorization with standard protocols like OpenID Connect. 

# Build
For testing and production we are using Dockerfile to build container. Docker Compose is used for ease of [theme development](#custom-theme-development).

```sh
docker build -f Dockerfile --build-arg THEME=$THEME --build-arg REALM=$REALM -t keycloak-custom
```

## Build arguments
Dockerfile has two arguments that is used to customize the build. 

### **THEME**   
Specify the theme that is going to be built in the container.

The theme folder according to the value is used in the build `./themes/${THEME}-theme`

### **REALM**   
Specify the realm (the configuration of the Keycloak instance) that is going to be built in the container and imported when started for the first time. Default value: main.

The realm configuration file according to the value is used in the build `./realms/${REALM}-realm.json`

# Custom theme development
Themes are used to configure the look and feel of login pages and the account management console. It is not recommended to
modify the existing built-in themes, instead you should create a new theme that extends a built-in theme. See the theme section in the [documentation](https://www.keycloak.org/docs/latest/server_development/#_themes) for more details.

## 1. Copy theme
Copy existing {theme}-theme and rename it as you need (or create new theme from scratch). 

**OPTIONAL.** *At login/theme.properties there is referenced file css/{theme}.css . To make it more clear for what this file is for, rename it as your theme-project and update reference*

## 2. Edit Docker Compose for development
Append docker-compose.yaml configuration by placing path to your theme in volumes.

## 3. Run Docker Compose
```sh
docker compose up -d --build
```
If everything is done correctly, keycloak now runs on *[localhost:8080/auth](http://localhost:8080/auth)*.

## 4. Login view editing and testing
To select your new theme for login view, go to *[localhost:8080/auth](http://localhost:8080/auth)* -> *Administration console* -> *Log in* -> *Realm settings* -> *Themes*
Select your new theme where necessary. For example, for login view theme change, select *{theme}-theme* at "Login theme" select.

To see changes in UI go to *[localhost:8080/auth](http://localhost:8080/auth)* -> *Users* -> *view All users* -> *Impersonate*.
 Now you are logged in as selected user. Copy the link in tab and log out. Enter the same link and you should be at your selected theme login view. If you edit login.ftl file, it should automatically update theme with changes.

## Other customisation suggestions
### 2. Changing logo
At the moment of writing, logo gets changed through realm. You need to create new realm for client and modify *HTML Display name*. Update also other values to be accurate.
 
### 3. Email templates
Edit templates under email/html and use variables from messages_en.properties (or other language).
 
**IMPORTANT!** Also some issues with encoding at email messages and passed the text that was not encoded correctly as param. This also should be handled better in future.

## Keycloak version tags
Inventing new version of Keycloak, tag the commit accordingly. This will allow to plan data migration actions together with upgrading older project to later development version. Name tags accordingly to the Keycloak version, e.g., KC11, KC16, KC19, etc.

## Migration between Keycloak version
Migration to a newer version of Keycloak typically is as simple as starting newer version of image with the existing database. Keycloak will upgrade the database automatically on start. **Important!** Backup before the upgrade and test.

Consider the need to update your client application as upgrading Keycloak may require upgrading client libraries that interact with Keycloak. E.g., Angular application may require client libraries upgrade.
