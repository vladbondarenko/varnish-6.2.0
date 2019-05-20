#!/bin/bash

ldconfig
systemctl daemon-reload
systemctl enable varnish
systemctl start varnish
