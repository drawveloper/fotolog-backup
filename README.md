# Fotolog Backup

Fotolog has no "export pictures" feature.

It has now.

### Usage

    git clone https://github.com/firstdoit/fotolog-backup.git
    cd fotolog-backup
    npm i
    coffee fotolog-build-index.coffee <username>
    coffee fotolog-download.coffee

Cheers

**Important**: requires node.js and coffee-script, naturally.
Install it with:

    npm i -g coffee-script
