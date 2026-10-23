module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.228000e+01> : tensor<1x9x10xf32>}> : () -> tensor<1x9x10xf32>
    %1 = tosa.sigmoid %0 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %2 = tosa.reduce_max %1 {axis = 1 : i32} : (tensor<1x9x10xf32>) -> tensor<1x1x10xf32>
    %cast = tensor.cast %2 : tensor<1x1x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

