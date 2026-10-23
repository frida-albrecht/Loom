module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.691000e+01> : tensor<4x2x4x1xf32>}> : () -> tensor<4x2x4x1xf32>
    %1 = tosa.reciprocal %0 : (tensor<4x2x4x1xf32>) -> tensor<4x2x4x1xf32>
    %2 = tosa.identity %1 : (tensor<4x2x4x1xf32>) -> tensor<4x2x4x1xf32>
    %3 = tosa.reciprocal %2 : (tensor<4x2x4x1xf32>) -> tensor<4x2x4x1xf32>
    %4 = tosa.sigmoid %3 : (tensor<4x2x4x1xf32>) -> tensor<4x2x4x1xf32>
    %5 = tosa.reciprocal %4 : (tensor<4x2x4x1xf32>) -> tensor<4x2x4x1xf32>
    %cast = tensor.cast %5 : tensor<4x2x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

