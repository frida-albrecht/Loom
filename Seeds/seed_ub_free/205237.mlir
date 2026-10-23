module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<181> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-24> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-7.943000e+01> : tensor<9x3x10xf32>}> : () -> tensor<9x3x10xf32>
    %3 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.negate %3, %4, %5 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %7 = tosa.bitwise_not %6 : (tensor<i32>) -> tensor<i32>
    %8 = tosa.bitwise_or %7, %7 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %9 = tosa.log %2 : (tensor<9x3x10xf32>) -> tensor<9x3x10xf32>
    %10 = tosa.reciprocal %9 : (tensor<9x3x10xf32>) -> tensor<9x3x10xf32>
    %cast = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<9x3x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

