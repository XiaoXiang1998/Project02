window.addEventListener('DOMContentLoaded', event => {
    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            labels: {
    placeholder: "搜尋",
    searchTitle: "Search within table",
    pageTitle: "Page {page}",
    perPage: "筆1頁",
    noRows: "查無資料",
    info: "Showing {start} to {end} of {rows} entries",
    noResults: "No results match your search query",
}
        });
        
    }
});
