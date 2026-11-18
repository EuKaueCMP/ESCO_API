import axios from "axios";

const api = axios.create({
  baseURL: process.env.API_BASE_URL ?? "http://localhost:5116/rbosfapi/v1",
  timeout: 20000,
});

export async function apiGet<T>(url: string): Promise<T | null> {
  try {
    const { data } = await api.get<T>(url);
    return data;
  } catch {
    return null;
  }
}

export default api;
