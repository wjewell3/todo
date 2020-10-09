defmodule TodoWeb.IndexLive do
    use Phoenix.LiveView
    alias Todo.Repo

    def mount(_params, _session, socket) do
        todos = Repo.all(Todo.Todo)
        socket = assign(socket, todos: todos)
        {:ok, socket}
    end

    def render(assigns) do
        ~L"""
        <h5>Tasks</h5>

        <ul  class="collection">
        <%= for todo <- @todos do %>
            <li class="collection-item">
            <%= case todo.status do %>
                <% 1 -> %>
                    <s><%=todo.action%></s>
                <% 0 -> %>
                    <%=todo.action%>
                <% end %>
            <div class="right">
                <%#= link "Complete", to: Routes.todo_path(@conn, :complete, todo) %> 
                <%#= link "Edit", to: Routes.live_path(@socket, :edit, todo) %> 
                <%#= link "  Delete", to: Routes.todo_path(@conn, :delete, todo), method: :delete %> 
            </div>
            </li>
        <% end %>
        </ul>

        """
    end

    # def handle_event("increment", _, socket) do
    #     count = socket.assigns.count + 1
    #     socket = assign(socket, :count, count)
    #     {:noreply, socket}
    # end

    # def handle_event("decrement", _, socket) do
    #     count = socket.assigns.count - 1
    #     socket = assign(socket, :count, count)
    #     {:noreply, socket}
    # end

    def handle_event("edit", _, socket) do
    
    end
end