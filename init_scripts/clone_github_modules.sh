#!/bin/bash

modules[0]='uofs-pulse-binfo/analyzedphenotypes'
modules[1]='uofs-pulse-binfo/chado_custom_search'
modules[2]='DivSeek-Canada/divseek-search'
modules[3]='uofs-pulse-binfo/nd_genotypes'
#modules[4]='uofs-pulse-binfo/tripal_ws_brapi'
modules[5]='statonlab/tripal_elasticsearch'
modules[6]='tripal/tripal_galaxy'
modules[7]='uofs-pulse-binfo/tripal_germplasm_importer'
modules[8]='tripal/tripal_jbrowse'
modules[9]='uofs-pulse-binfo/tripal_qtl'
modules[10]='tripal/tripald3'
modules[11]='tripal/trpdownload_api'
modules[13]='tripal/trpfancy_fields'
modules[14]='uofs-pulse-binfo/vcf_filter'
modules[15]='DivSeek-Canada/tripal-crop-configure'

for repo in "${modules[@]}"; do
  url="https://api.github.com/repos/$repo/releases/latest" \
  latest=`curl -s $url |  grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'`
  if [[ -n "$latest" ]]; then
    echo "github/$repo version $latest"
    git clone --quiet https://github.com/$repo.git --branch=$latest
  else
    echo "github/$repo version HEAD"
    git clone --quiet https://github.com/$repo.git
  fi
done
