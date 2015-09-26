# Data Preparation
allissues <- readRDS("data/Issues.RDS")

summary(allissues$TotalTime)

allissues$ResolutionDays = round(allissues$TotalTime  / 24 / 60,2)

allissues$DepNombre = trimws(as.character(allissues$DepNombre))

# Filter and prepare data
cleantable <- allissues %>% filter(IssueYear==2014 & DepId %in% c(1,2,3,4,5,8) & MorNombre != 'Terceros' & ResolutionDays < 10) %>% 
  select(
    Id = OdtId,
    Type = MorNombre, 
    Zone = DepNombre,
    Start = EsoFechaHoraOriginada,
    End = EsoFechaHoraFinalizada,
    Month = IssueMonth, 
    ResolutionDays
  )

cleantable$Type = factor(cleantable$Type)
cleantable$Zone = factor(cleantable$Zone)

saveRDS(cleantable, "data/CleanIssues.RDS")

# g <- ggplot(issuesByType, aes(x=Type, y=MonthlyIssues, fill = Type)) +
#   ggtitle("Monthly Issues By Type")
#   geom_boxplot() + scale_y_sqrt() + scale_y + scale_y_log() 
# g

