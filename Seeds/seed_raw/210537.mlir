module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.430500e+02> : tensor<2x9x10xf32>}> : () -> tensor<2x9x10xf32>
    %1 = tosa.log %0 : (tensor<2x9x10xf32>) -> tensor<2x9x10xf32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<2x9x10xf32>, tensor<2x9x10xf32>) -> tensor<2x18x10xf32>
    %3 = tosa.log %2 : (tensor<2x18x10xf32>) -> tensor<2x18x10xf32>
    %cast = tensor.cast %3 : tensor<2x18x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

