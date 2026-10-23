module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<108> : tensor<1x7x2x4xi32>}> : () -> tensor<1x7x2x4xi32>
    %1 = "tosa.const"() <{values = dense<47> : tensor<1x7x1x1xi32>}> : () -> tensor<1x7x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-6.723000e+01> : tensor<1x9x10xf32>}> : () -> tensor<1x9x10xf32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<1x7x2x4xi32>, tensor<1x7x1x1xi32>) -> tensor<1x7x2x4xi32>
    %4 = tosa.intdiv %3, %3 : (tensor<1x7x2x4xi32>, tensor<1x7x2x4xi32>) -> tensor<1x7x2x4xi32>
    %5 = tosa.tanh %2 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %6 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %6, %7, %8 : (tensor<1x9x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x9x10xf32>
    %10 = tosa.ceil %9 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %11 = tosa.add %9, %6 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %12 = tosa.add %10, %11 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %cast = tensor.cast %4 : tensor<1x7x2x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<1x9x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

