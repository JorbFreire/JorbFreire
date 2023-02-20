import json
from inquirer import List, confirm, prompt

def delete_project(project_list_path):
  projects_list = []

  with open(project_list_path, 'r') as openfile:
    projects_list = json.load(openfile)
  
  projects_keys=[project["name"] for project in projects_list]

  questions = [
    List(
      'selected_project',
      message="Delete a project",
      choices=projects_keys,
    ),
    confirm(
      'delete_confirmed',
      message="This project will be deleted. Continue?",
      default=False
    ),
    confirm(
      'delete_confirmed2',
      message="ARE YOU SURE???",
      default=False
    )
  ]

  selected_project = prompt(questions)["selected_project"]
  
  if selected_project['delete_confirmed'] and selected_project['delete_confirmed2']:
    raise Exception("Deletion Aborted!")

  projects_list = list(
    filter(
      lambda project: project['name'] != selected_project,
      projects_list
    )
  )

  with open(project_list_path, "w") as outfile:
    outfile.write(json.dumps(projects_list, indent=4))
  
  print('Project named as "{selected_project}" has been deleted!')
