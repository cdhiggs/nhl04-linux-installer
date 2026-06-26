use std::env;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    env::set_var("WEBKIT_DISABLE_DMABUF_RENDERER", "1"); // Workaround Tauri AppImage Webkit2GTK issues
    env::set_var("WEBKIT_DISABLE_COMPOSITING_MODE", "1");

    tauri::Builder::default()
        .plugin(tauri_plugin_dialog::init())
        .plugin(tauri_plugin_shell::init())
        .plugin(tauri_plugin_fs::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
