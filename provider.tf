provider "aws" {
  alias                    = "aws"
  region                   = var.region
  profile                  = "default"
  shared_credentials_files = ["~/.aws/credentials"]

  default_tags {
    tags = {
      author     = "Martín E. Zahnd"
      version    = 1
      university = "ITBA"
      subject    = "Cloud Computing"
      created-by = "terraform"
    }
  }
}
