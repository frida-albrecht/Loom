module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.397800e+02> : tensor<5x10x7xf32>}> : () -> tensor<5x10x7xf32>
    %1 = tosa.abs %0 : (tensor<5x10x7xf32>) -> tensor<5x10x7xf32>
    %2 = tosa.minimum %1, %1 : (tensor<5x10x7xf32>, tensor<5x10x7xf32>) -> tensor<5x10x7xf32>
    %3 = tosa.sigmoid %2 : (tensor<5x10x7xf32>) -> tensor<5x10x7xf32>
    %4 = tosa.sub %3, %3 : (tensor<5x10x7xf32>, tensor<5x10x7xf32>) -> tensor<5x10x7xf32>
    %cast = tensor.cast %4 : tensor<5x10x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

