#! /usr/bin/env python
# coding=utf-8

import glob
import os
import sys
import json
from os.path import expanduser, exists, join

HOME = os.environ.get("HOME", expanduser("~"))
CURRENT_DIR = os.path.abspath(os.path.dirname(__file__))
WORKSPACE = os.environ.get("WORKSPACE", join(HOME, "workspace"))
PROJECTS_JSON = join(CURRENT_DIR, "projects.json")
DEEPTH = 3


def _load_projects():
    if not exists(PROJECTS_JSON):
        return {}

    with open(PROJECTS_JSON) as f:
        try:
            projects = json.load(f)
        except:
            projects = {}
    return projects or {}


def _update_projects(projects_json):
    with open(PROJECTS_JSON, "w") as f:
        json.dump(projects_json, f)
    print("Update projects json success!!!")


def assemble(project_name, deepth=DEEPTH):
    projects = _load_projects()
    found = []
    for i in range(deepth):
        file_path = join(WORKSPACE, f"*/" * i)
        targets = glob.glob(join(WORKSPACE, f"{file_path}", f"{project_name}"))
        if targets:
            found.extend(targets)

    if not found:
        print("Found nothing, please make sure you had typed the right project name.")
        return None

    if len(found) > 1:
        for i, v in enumerate(found):
            print(f"{i}: {v}")

        choose = input("Please select the right project:\n")
        selected = found[int(choose)]
    else:
        selected = found[0]

    projects[project_name] = selected

    _update_projects(projects)

    return selected


def goto(project_name):
    projects = _load_projects()
    project_path = ""
    if project_name in projects:
        project_path = projects[project_name]
    else:
        found = assemble(project_name)
        if found:
            project_path = found
    print(project_path)
    return project_path


def alias(project_name, alias_):
    projects = _load_projects()
    if project_name in projects:
        projects[alias_] = projects[project_name]
    else:
        found = assemble(project_name)
        if found:
            projects[alias_] = found
            projects = _load_projects()

    _update_projects(projects)


if __name__ == "__main__":
    args = sys.argv

    if len(args) < 3:
        print("Must call this script with function name and arguments.")
    func = args[1]
    if func == "goto":
        goto(args[2])
    elif func == "assemble":
        assemble(args[2])
    elif func == "alias":
        alias(args[2], args[3])
    else:
        print("Only goto, assemble and alias, are supported.")

