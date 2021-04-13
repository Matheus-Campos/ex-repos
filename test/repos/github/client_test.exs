defmodule Repos.Github.ClientTest do
  use ExUnit.Case, async: true

  import Plug.Conn

  alias Repos.Github.Client
  alias Repos.{Error, Repository}

  describe "get_repos_by_username/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when the username is valid, should return all public repos of the user", %{
      bypass: bypass
    } do
      username = "Matheus-Campos"

      url = endpoint_url(bypass.port)

      body = ~s([{
        "id": 355934375,
        "node_id": "MDEwOlJlcG9zaXRvcnkzNTU5MzQzNzU=",
        "name": "ex-repos",
        "full_name": "Matheus-Campos/ex-repos",
        "private": false,
        "owner": {
          "login": "Matheus-Campos",
          "id": 21260809,
          "node_id": "MDQ6VXNlcjIxMjYwODA5",
          "avatar_url": "https://avatars.githubusercontent.com/u/21260809?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/Matheus-Campos",
          "html_url": "https://github.com/Matheus-Campos",
          "followers_url": "https://api.github.com/users/Matheus-Campos/followers",
          "following_url": "https://api.github.com/users/Matheus-Campos/following{/other_user}",
          "gists_url": "https://api.github.com/users/Matheus-Campos/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/Matheus-Campos/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/Matheus-Campos/subscriptions",
          "organizations_url": "https://api.github.com/users/Matheus-Campos/orgs",
          "repos_url": "https://api.github.com/users/Matheus-Campos/repos",
          "events_url": "https://api.github.com/users/Matheus-Campos/events{/privacy}",
          "received_events_url": "https://api.github.com/users/Matheus-Campos/received_events",
          "type": "User",
          "site_admin": false
        },
        "html_url": "https://github.com/Matheus-Campos/ex-repos",
        "description": null,
        "fork": false,
        "url": "https://api.github.com/repos/Matheus-Campos/ex-repos",
        "forks_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/forks",
        "keys_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/teams",
        "hooks_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/hooks",
        "issue_events_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/issues/events{/number}",
        "events_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/events",
        "assignees_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/assignees{/user}",
        "branches_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/branches{/branch}",
        "tags_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/tags",
        "blobs_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/languages",
        "stargazers_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/stargazers",
        "contributors_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/contributors",
        "subscribers_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/subscribers",
        "subscription_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/subscription",
        "commits_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/contents/{+path}",
        "compare_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/merges",
        "archive_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/downloads",
        "issues_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/issues{/number}",
        "pulls_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/labels{/name}",
        "releases_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/releases{/id}",
        "deployments_url": "https://api.github.com/repos/Matheus-Campos/ex-repos/deployments",
        "created_at": "2021-04-08T14:13:27Z",
        "updated_at": "2021-04-09T02:32:21Z",
        "pushed_at": "2021-04-09T02:32:19Z",
        "git_url": "git://github.com/Matheus-Campos/ex-repos.git",
        "ssh_url": "git@github.com:Matheus-Campos/ex-repos.git",
        "clone_url": "https://github.com/Matheus-Campos/ex-repos.git",
        "svn_url": "https://github.com/Matheus-Campos/ex-repos",
        "homepage": null,
        "size": 23,
        "stargazers_count": 0,
        "watchers_count": 0,
        "language": "Elixir",
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": true,
        "has_pages": false,
        "forks_count": 0,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 0,
        "license": null,
        "forks": 0,
        "open_issues": 0,
        "watchers": 0,
        "default_branch": "main"
      }])

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> resp(200, body)
      end)

      response = Client.get_repos_by_username(url, username)

      expected_response =
        {:ok,
         [
           %Repository{
             description: nil,
             html_url: "https://github.com/Matheus-Campos/ex-repos",
             id: 355_934_375,
             name: "ex-repos",
             stargazers_count: 0
           }
         ]}

      assert response == expected_response
    end

    test "when the user is not found, returns an error", %{bypass: bypass} do
      username = "a-vie"

      url = endpoint_url(bypass.port)

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> put_resp_header("content-type", "application")
        |> resp(404, body)
      end)

      response = Client.get_repos_by_username(url, username)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end

    test "when an unexpected error occurs, should recover from it", %{bypass: bypass} do
      username = "a-vie"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repos_by_username(url, username)

      expected_response = {:error, %Error{result: :econnrefused, status: :internal_server_error}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
