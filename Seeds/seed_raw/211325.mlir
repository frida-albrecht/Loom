module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<110> : tensor<10x4x8x5xi32>}> : () -> tensor<10x4x8x5xi32>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<10x4x8x5xi32>) -> tensor<10x4x8x1xi32>
    %2 = tosa.add %1, %1 : (tensor<10x4x8x1xi32>, tensor<10x4x8x1xi32>) -> tensor<10x4x8x1xi32>
    %cast = tensor.cast %2 : tensor<10x4x8x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

