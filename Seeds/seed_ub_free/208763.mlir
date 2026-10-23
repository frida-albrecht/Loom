module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<94> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<33> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-115> : tensor<10x5xi32>}> : () -> tensor<10x5xi32>
    %3 = "tosa.const"() <{values = dense<-1.652200e+02> : tensor<10xf32>}> : () -> tensor<10xf32>
    %4 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<10x5xi32>) -> tensor<1x5xi32>
    %6 = tosa.tanh %3 : (tensor<10xf32>) -> tensor<10xf32>
    %7 = tosa.clz %4 : (tensor<i32>) -> tensor<i32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<1x5xi32>}> : () -> tensor<1x5xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<1x5xi32>}> : () -> tensor<1x5xi32>
    %a1 = tosa.maximum %5, %c1 : (tensor<1x5xi32>, tensor<1x5xi32>) -> tensor<1x5xi32>
    %a2 = tosa.minimum %a1, %c2 : (tensor<1x5xi32>, tensor<1x5xi32>) -> tensor<1x5xi32>
    %8 = tosa.logical_left_shift %5, %a2 : (tensor<1x5xi32>, tensor<1x5xi32>) -> tensor<1x5xi32>
    %9 = tosa.minimum %6, %6 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %10 = tosa.bitwise_not %8 : (tensor<1x5xi32>) -> tensor<1x5xi32>
    %11 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %12 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %13 = tosa.negate %6, %11, %12 : (tensor<10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<10xf32>
    %cast = tensor.cast %7 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<1x5xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %13 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}