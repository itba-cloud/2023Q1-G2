# locals {
#   filetypes = {
#     "html" : "text/html",
#     "jpg" : "image/jpg",
#     "jpeg" : "image/jpeg",
#     "png" : "image/png",
#     "css" : "text/css",
#     "js" : "application/javascript",
#     "json" : "application/json",
#   }

#   file_with_mime = flatten([
#     for type, mime in local.filetypes : [
#       for key, value in fileset("${var.resources}/", "**/*.${type}") : {
#         mime      = mime
#         file_name = value
#       }
#     ]
#   ])
# }
