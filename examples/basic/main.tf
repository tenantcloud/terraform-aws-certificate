module "acm" {
    source = "../../"

    domain_name = {
        zone = "example.com"
        domain = "example.com"
    }
    alternative_names = [
        {
            zone = "example.com"
            domain = "*.example.com"
        },
        {
            zone = "example.org"
            domain = "example.org"
        },
        {
            zone =  "example.org"
            domain = "*.example.org"
        }
    ]

    tags = {
        Name = "ACM certificate with multiple hosted zones"
    }
}