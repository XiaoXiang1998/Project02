window.addEventListener('DOMContentLoaded', event => {
    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            labels: {
    placeholder: "搜尋",
    searchTitle: "Search within table",
    pageTitle: "Page {page}",
    perPage: "筆1頁",
    noRows: "目前沒有資料",
    info: "第 {start} 到第 {end} 筆訂單 總共 {rows} 筆訂單",
    noResults: "查無資料",
}
        });
        
    }
});
