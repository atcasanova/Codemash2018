#!/bin/bash
#strings chest  | grep -P "cm18((?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d-])"
strings chest | grep cm18 | grep -vE -- "-[a-z]{4}$"
