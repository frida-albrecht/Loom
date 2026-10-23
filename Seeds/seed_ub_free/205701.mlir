module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.467000e+01> : tensor<4x6x8xf32>}> : () -> tensor<4x6x8xf32>
    %1 = tosa.floor %0 : (tensor<4x6x8xf32>) -> tensor<4x6x8xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.negate %1, %2, %3 : (tensor<4x6x8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x8xf32>
    %5 = tosa.concat %4, %4 {axis = 1 : i32} : (tensor<4x6x8xf32>, tensor<4x6x8xf32>) -> tensor<4x12x8xf32>
    %cast = tensor.cast %5 : tensor<4x12x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

