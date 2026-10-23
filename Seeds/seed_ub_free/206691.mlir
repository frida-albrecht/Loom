module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.705400e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<1xf32>
    %cast = tensor.cast %1 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

