% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kobo_get_project_list.R
\name{kobo_get_project_list}
\alias{kobo_get_project_list}
\title{Functions starting with kobo_ are a set of functions to interact with the datacollection tool kobotoolbox.
Lists all kobo projects/assets available for a user.}
\usage{
kobo_get_project_list(url, username, password)
}
\arguments{
\item{url}{URL to kobotoolbox, for example https://kf.kobo.prod.in.noacs.io}

\item{username}{Username for kobotoolbox}

\item{password}{Password for kobotoolbox}
}
\value{
projects A dataframe containing a list of projects available to the user, their uids and number of submissions.
}
\description{
Functions starting with kobo_ are a set of functions to interact with the datacollection tool kobotoolbox.
Lists all kobo projects/assets available for a user.
}
