local Matrix = {}

function Matrix.new(matrix: {{number}})
	return setmetatable(matrix, Matrix)
end
 
function Matrix.byAngleX(theta: number)
	local sin, cos = math.sin(theta), math.cos(theta)
 
	return Matrix.new({
		{1, 0, 0},
		{0, cos, -sin},
		{0, sin, cos}
	})
end
 
function Matrix.byAngleY(theta: number)
	local sin, cos = math.sin(theta), math.cos(theta)
 
	return Matrix.new({
		{cos, 0, -sin},
		{0, 1, 0},
		{sin, 0, cos}
	})
end
 
function Matrix.byAngleZ(theta: number)
	local sin, cos = math.sin(theta), math.cos(theta)

	return Matrix.new({
		{cos, -sin, 0},
		{sin, cos, 0},
		{0, 0, 1}
	})
end
 
function Matrix:GetCFrame(position: Vector3?)
	local cframePosition = position or Vector3.zero
 
	return CFrame.new(
		cframePosition.X, cframePosition.Y, cframePosition.Z,
 
		self[1][1], self[1][2], self[1][3],
		self[2][1], self[2][2], self[2][3],
		self[3][1], self[3][2], self[3][3]
	)
end
 
Matrix.__index = Matrix
Matrix.__mul = function(matrix1, matrix2)
	return Matrix.new({
		{
			matrix1[1][1] * matrix2[1][2] + matrix1[1][2] * matrix2[2][1] + matrix1[1][3] * matrix2[3][1],
			matrix1[1][1] * matrix2[1][2] + matrix1[1][2] * matrix2[2][2] + matrix1[1][3] * matrix2[3][2],
			matrix1[1][1] * matrix2[1][3] + matrix1[1][2] * matrix2[2][3] + matrix1[1][3] * matrix2[3][3],
		},
 
		{
			matrix1[2][1] * matrix2[1][2] + matrix1[2][2] * matrix2[2][1] + matrix1[2][3] * matrix2[3][1],
			matrix1[2][1] * matrix2[1][2] + matrix1[2][2] * matrix2[2][2] + matrix1[2][3] * matrix2[3][2],
			matrix1[2][1] * matrix2[1][3] + matrix1[2][2] * matrix2[2][3] + matrix1[2][3] * matrix2[3][3],
		},
 
		{
			matrix1[3][1] * matrix2[1][2] + matrix1[3][2] * matrix2[2][1] + matrix1[3][3] * matrix2[3][1],
			matrix1[3][1] * matrix2[1][2] + matrix1[3][2] * matrix2[2][2] + matrix1[3][3] * matrix2[3][2],
			matrix1[3][1] * matrix2[1][3] + matrix1[3][2] * matrix2[2][3] + matrix1[3][3] * matrix2[3][3],
		},
	})
end

return Matrix
