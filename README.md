
<!-- README.md is generated from README.Rmd. Please edit that file -->

# profiles

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of {profiles} is to allow users to create and quickly switch
between different RStudio “profiles.” Profiles control various user
preferences ranging from editor appearance (e.g., color theme, font,
font size, zoom level, pane layout), dictionaries, and key bindings.
This ability is particularly useful when different configurations would
be useful at different times. For example, I use a heavily customized
version of RStudio when doing my own coding; however, when teaching in
R, I often want to revert back to the default configuration and increase
the zoom level and font size. Using {profiles}, I can save profiles for
`"working"` and `"teaching"` and swap between them with the click of a
button.

## Installation

You can install the development version of profiles from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jmgirard/profiles")
```

## Example

### Functions

To create a new profile, first configure your RStudio however you like
(using Tools \> Global Options…). Then use `save_profile()` to save the
current configuration for later use. We can name it something like
`"working"` to help us remember it.

``` r
save_profile("working")
```

Then, let’s say you want to do some teaching. You can use
`default_profile()` to quickly jump back to the RStudio default
configuration.

``` r
default_profile()
```

Then I can adjust this to my liking, perhaps increasing the zoom level
and font size. If I know I will be teaching again later, I can save this
profile as well with the name `"teaching"`.

``` r
save_profile("teaching")
```

Finally, after teaching is done, you might want to jump back into work.
You can use `open_profile()` to quickly jump back into a previously
saved configuration, such as `"working"`.

``` r
open_profile("working")
```

If you ever want to check which profiles are available for the current
user, you can use `list_profiles()` and this will print all profile
names to the console. If you are done with a profile, you can also
remove it by providing that profile’s name to `remove_profile()` .

### Addin

For even easier access to these functions, each has an associated option
under the RStudio Addins menu. They work the same way as the functions
but will prompt you for the profile names via modal windows.

![Addin screenshot](https://i.imgur.com/5wYfA1q.png)
