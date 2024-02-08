# MPred Lab Website

IMAS MPred Lab Quarto Website

### Build process (to sync latest changes to the site files)

The website rebuilds when:

1.  a new commit is pushed to `main` branch

2.  the `Publish Quarto` action is manually executed on github

3.  The following is run in the terminal (example in RStudio)

    ```         
    quarto publish gh-pages
    ```

See <https://quarto.org/docs/publishing/github-pages.html>
