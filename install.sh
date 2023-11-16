#!/bin/bash

declare -a repos=("${@}");

github_repo_search_url_base="https://api.github.com/search/repositories?q=nicolachoquet06250"

for repo_name in "${repos[@]}";do
    if [[ "${GITHUB_INSTALL_ACCESS_TOKEN}" != "" ]];then
        curl_result="$(curl -s "${github_repo_search_url_base}/${repo_name}" \
            --header "Authorization: Bearer ${GITHUB_INSTALL_ACCESS_TOKEN}")"
    else
        curl_result="$(curl -s "${github_repo_search_url_base}/${repo_name}")"
    fi

    total_count=$(jq -r ".total_count" <<<"$curl_result")

    if [[ $total_count -eq 0 ]];then
        echo "existe pas"
    elif [[ $total_count -gt 1 ]];then
        echo "trop grand"
    elif [[ $total_count -eq 1 ]];then
        repo="$(jq -r ".items[0].ssh_url" <<<"$curl_result")"

        if [[ ! -d "$(pwd)/${repo_name}" ]];then
          echo "${repo}"
          git clone "${repo}"
          if {
              [[ -f "$(pwd)/${repo_name}/.githooks/post-checkout" ]] &&
              [[ ! -f "$(pwd)/${repo_name}/.git/hooks/post-checkout" ]]
          };then
            ln -s "$(pwd)/${repo_name}/.githooks/post-checkout" "$(pwd)/${repo_name}/.git/hooks/post-checkout"
          fi

          # shellcheck disable=SC1090
          . "$(pwd)/${repo_name}/.git/hooks/post-checkout" "install-script"
        fi
    fi
done