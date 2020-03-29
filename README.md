# README

## table
- user
  - id
  - name : string
  - email : string
  - password_digest : string
  - admin : integer

- task
  - id
  - name : string
  - content : text
  - end_date : date
  - priority : integer
  - status : integer
  - user_id : integer

- labeling
  - id
  - task_id : integer
  - label_id : integer

- label
  - id
  - name : string
