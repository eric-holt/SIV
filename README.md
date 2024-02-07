# Simple Interactive Viewer
Render multiple Plotly plots and DT tables from RDS files via drag-and-drop. Instantly view and share interactive plots and tables.

## Usage

1. Save a supported R object (see below) as RDS
2. Drag the RDS file to Viewer
3. View plot/table interactively
4. Add (`+`) more files as you need 

## Supported object classes
- `plotly`
- `ggplot`
- `data.frame` (and others like `data.table`)
- (`datatables`)

## Notes

Use `saveRDS()` to save an object in R. 

This app converts ggplot into Plotly using `ggplotly()` and data.frame-like object (like data.table) into DT using `datatable()`. 

DT objects work locally but fails in the [shinyapps.io](https://a4d9lq-eric-holt.shinyapps.io/SimplePlotlyViewer/) instance. Just use the original table.


Available at: 
<https://a4d9lq-eric-holt.shinyapps.io/SimplePlotlyViewer/>
