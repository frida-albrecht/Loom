module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.013200e+02> : tensor<7x9x2x3xf32>}> : () -> tensor<7x9x2x3xf32>
    %1 = "tosa.const"() <{values = dense<-91> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-166> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.sigmoid %0 : (tensor<7x9x2x3xf32>) -> tensor<7x9x2x3xf32>
    %4 = tosa.tanh %3 : (tensor<7x9x2x3xf32>) -> tensor<7x9x2x3xf32>
    %5 = tosa.sub %4, %4 : (tensor<7x9x2x3xf32>, tensor<7x9x2x3xf32>) -> tensor<7x9x2x3xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.log %5 : (tensor<7x9x2x3xf32>) -> tensor<7x9x2x3xf32>
    %8 = tosa.concat %7, %5 {axis = 3 : i32} : (tensor<7x9x2x3xf32>, tensor<7x9x2x3xf32>) -> tensor<7x9x2x6xf32>
    %9 = tosa.exp %8 : (tensor<7x9x2x6xf32>) -> tensor<7x9x2x6xf32>
    %cast = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<7x9x2x6xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

