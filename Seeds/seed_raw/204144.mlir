module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.344500e+02> : tensor<7x4x7xf32>}> : () -> tensor<7x4x7xf32>
    %1 = tosa.reciprocal %0 : (tensor<7x4x7xf32>) -> tensor<7x4x7xf32>
    %2 = tosa.abs %1 : (tensor<7x4x7xf32>) -> tensor<7x4x7xf32>
    %3 = tosa.reduce_product %2 {axis = 0 : i32} : (tensor<7x4x7xf32>) -> tensor<1x4x7xf32>
    %cast = tensor.cast %3 : tensor<1x4x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

