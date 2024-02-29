# Tampermonkey Userscripts

- Install the [Tampermonkey](https://www.tampermonkey.net/) extension for your browser.
- Go to the extension's dashboard page, or click the 'Create a new script' option from the menu icon.
- Copy and past one of the scripts below and edit the params as mentioned below.

## Jira Sort

- What: Automatically sort comments in a Jira ticket by 'Oldest first'.
- Where: [jira_sort.js](jira_sort.js)
- How: Copy the script in Tampermonkey and replace `jira.example.com` in the `@match` param on line 7 with the domain:port for your Jira server.
