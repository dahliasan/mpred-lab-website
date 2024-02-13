# MPred Lab Website

IMAS MPred Lab Quarto Website

## Processes

### Adding / Updating Members

1. Add / update member details in `members.csv`
2. Run `scripts/generateMembersDbYaml.R` to generate new `db/members.yaml`
3. Optional: Create new `qmd` file for the member in `members/` directory.
   - Make sure `slug` in `members.csv` matches the filename of the `qmd` file.

### Build (update website) the website after changes

1.  Run the following in the terminal (not the console!) in RStudio

    ```
    quarto publish netlify
    ```

See <https://quarto.org/docs/publishing>

### How to contribute to the website

We welcome contributions from everyone part of the lab. Here are the steps to contribute:

1. **Fork the repository**
   Click on the `Fork` button at the top right corner of the repository page on GitHub.

2. **Clone the forked repository**
   Navigate to your GitHub repositories and find the forked repository. Click on the `Code` button and copy the URL.

   - **For VS Code**:

     - Open VS Code, click on `View` > `Command Palette` or press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac).
     - Type `Git: Clone` and press `Enter`.
     - Paste the copied URL and press `Enter`.
     - Choose the directory where you want to clone the repository and click `Select Repository Location`.
     - A popup will appear asking if you would like to open the cloned repository, click `Open`.

   - **For RStudio**:
     - Open RStudio, click on `File` > `New Project` > `Version Control` > `Git`.
     - In the `Repository URL` field, paste the copied URL.
     - Choose the directory where you want to clone the repository in the `Create project as a subdirectory of` field.
     - Click `Create Project`.

3. **Create a new branch** (optional)
   It's a good practice to create a new branch for each new feature or bug fix. You can do this using GitHub Desktop or the command line.

4. **Make your changes**
   Navigate to the local path of the repository and make your changes in the code.

5. **Commit your changes**
   Commit your changes using GitHub Desktop or the command line.

6. **Push your changes to GitHub**
   Push your changes to the remote repository on GitHub using GitHub Desktop or the command line.

7. **Create a pull request**
   Navigate to the original repository on GitHub. Click on the `Pull requests` tab. Click on the `New pull request` button. Choose your fork and the branch you worked on. Click on `Create pull request`.
