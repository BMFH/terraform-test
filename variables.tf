variable "myvar" {
  type        = string
  default     = "Hello World!"
  description = "my test var"
}

variable "subnets" {
  type        = map
  default     = {
      subnet1 = "subnet1"
      subnet2 = "subnet2"
      subnet3 = "subnet333"
  }
  description = "some subnets names"
}

variable "mylist" {
  type        = list
  default     = ["item1", "item2"]
  description = "this is a list"
}
