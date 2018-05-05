#!/bin/bash

# Login to Heroku
heroku login
heroku git:remote -a landmark-challenge

# Deploy of src/ subtree
git subtree push --prefix src/ heroku master
