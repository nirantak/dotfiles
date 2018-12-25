# Visual Studio Code Settings

## Setup

-   Install VSCode from [here](https://code.visualstudio.com/Download).

-   Install extensions:

    ```bash
    $ cat ~/dotfiles/vscode/extensions.txt | xargs -L1 code --install-extension
    ```

-   Copy all settings from `settings.json`

## Save extension list

```bash
$ code --list-extensions > ~/dotfiles/vscode/extensions.txt
```
