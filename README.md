# Installing Verto
Before we can use Verto, we'll need to install it. There are two options available:

Install FreeSWITCH + Verto
# Install Verto only
If you're going to use a self hosted FreeSWITCH server you can use the FreeSWITCH Installation Guide and mod_verto Guide.

If you have an external FreeSWITCH server with mod_verto enabled or just wish to use Verto stand-alone, follow the next steps.

# Requirements
We need Node.js installed in order to have access to its package manager, npm.

# Installing
Verto
With Node.js installed and Node Package Manager available, install verto library inside lib/ directory.:

npm install verto
Verto library should be installed in lib/node_modules/verto/ directory now.

# Dependencies
Verto depends on jQuery and jQuery JSON, so let's install them too:

npm install jquery
npm install jquery-json
