# Global Code

library(dplyr)

# Read Issues Data
issues <- readRDS("data/CleanIssues.RDS")

# Monthly Issues By Type
issuesByType <- issues %>% group_by(Type, Month) %>% summarise(Count = n(), Resolution = mean(ResolutionDays))

# Monthly Issues By Zone
issuesByZone <- issues %>% group_by(Zone, Month) %>% summarise(Count = n(), Resolution = mean(ResolutionDays))

# Zones Vector
zones <- as.character(unique(issues$Zone))

# Types Vector
types <- as.character(unique(issues$Type))

# Train Predictor usin linear regression
fit <- lm(ResolutionDays ~ Type + Zone, data=issues)



