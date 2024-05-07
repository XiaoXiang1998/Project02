window.addEventListener('DOMContentLoaded', event => {
    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            "language": {
                "url":"//cdn.datatables.net/plug-ins/2.0.7/i18n/zh-HANT.json",
                "lengthMenu":"顯示 _MENU_ 項資料",
            }
        });
    }
});
