import os
import requests
import semver


def main():
    token = os.environ.get("GITHUB_TOKEN")
    headers: dict[str, str] = {}
    if token:
        headers["Authorization"] = token

    r = requests.get("https://api.github.com/repos/SillyTavern/SillyTavern/releases", headers=headers).json()[:5]
    versions = [{ "version": i["tag_name"], "dockerfile": f"Dockerfile.{i["tag_name"]}" } for i in r if i.get("tag_name")]
    versions.insert(0, { "version": "latest", "dockerfile": "Dockerfile.latest" })
    rt = { "include": versions }
    print(rt)


if __name__ == "__main__":
    main()
