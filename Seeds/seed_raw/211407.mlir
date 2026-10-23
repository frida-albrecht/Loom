module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<200> : tensor<5xi64>}> : () -> tensor<5xi64>
    %1 = "tosa.const"() <{values = dense<46> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<-1.221300e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<5xi64>, tensor<1xi64>) -> tensor<5xi64>
    %4 = tosa.sub %3, %3 : (tensor<5xi64>, tensor<5xi64>) -> tensor<5xi64>
    %5 = tosa.floor %2 : (tensor<3xf32>) -> tensor<3xf32>
    %6 = tosa.pow %5, %5 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %7 = tosa.bitwise_not %4 : (tensor<5xi64>) -> tensor<5xi64>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %10 = tosa.negate %5, %8, %9 : (tensor<3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<3xf32>
    %cast = tensor.cast %6 : tensor<3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<5xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %10 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

