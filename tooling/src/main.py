import sys
from pathlib import Path

from actions.select_project import select_project
from actions.create_project import create_project
from actions.delete_project import delete_project

project_list_path = Path(__file__).parent / "projects_list.json"


if __name__ == "__main__":
  if len(sys.argv) < 2:
    print(select_project(project_list_path))

  option = sys.argv[1]

  if option == "create":
    create_project(project_list_path)

  if option == "delete":
    delete_project(project_list_path)

  if option == "--help":
    print("avaliable options:") 
    print("  default: run\n")  
    print("  create: create a new project\n") 
    print("  delete: delete a project\n") 
