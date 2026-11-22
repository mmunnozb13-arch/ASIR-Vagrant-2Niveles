#!/bin/bash
# Elimina la ruta por defecto: la máquina deja de tener salida a Internet.
# El acceso SSH de Vagrant sigue funcionando porque entra por la red NAT local.
ip route del default || true
