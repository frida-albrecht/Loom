module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.630400e+02> : tensor<5x9x6xf32>}> : () -> tensor<5x9x6xf32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<5x9x6xf32>) -> tensor<1x9x6xf32>
    %cast = tensor.cast %1 : tensor<1x9x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

