# MazeViz struct for visualization logic
struct MazeViz
    mat::Matrix{Node}
end

# Function to draw the maze in the terminal
function draw_maze(viz::MazeViz)
    mat = viz.mat
    height, width = size(mat)
    output = IOBuffer()

    for i in 1:height
        # Draw the top boundary of the row
        for j in 1:width
            node = mat[i, j]
            if node.up === nothing
                print(output, "+---")
            else
                print(output, "+   ")
            end
        end
        println(output, "+")

        # Draw the side boundaries and paths of the row
        for j in 1:width
            node = mat[i, j]
            if node.left === nothing
                print(output, "|   ")
            else
                print(output, "    ")
            end
        end
        println(output, "|")
    end

    # Draw the bottom boundary of the last row
    for j in 1:width
        print(output, "+---")
    end
    println(output, "+")

    return String(take!(output))
end

# Overload Base.show for MazeViz to display the maze
function Base.show(io::IO, viz::MazeViz)
    print(io, draw_maze(viz))
end

# Overload Base.show for the matrix of Nodes
function Base.show(io::IO, mat::Matrix{Node})
    viz = MazeViz(mat)
    show(io, viz)
end
