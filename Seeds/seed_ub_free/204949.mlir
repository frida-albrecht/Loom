module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.609000e+01> : tensor<10x2x1xf32>}> : () -> tensor<10x2x1xf32>
    %1 = "tosa.const"() <{values = dense<-131> : tensor<2x3x2xi16>}> : () -> tensor<2x3x2xi16>
    %2 = "tosa.const"() <{values = dense<-167> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %3 = tosa.floor %0 : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %c0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<10x2x1xf32>}> : () -> tensor<10x2x1xf32>
    %t0 = tosa.maximum %3, %c0 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %c1 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<10x2x1xf32>}> : () -> tensor<10x2x1xf32>
    %t1 = tosa.maximum %3, %c1 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %4 = tosa.pow %t0, %t1 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %5 = tosa.bitwise_and %1, %2 : (tensor<2x3x2xi16>, tensor<1x1x1xi16>) -> tensor<2x3x2xi16>
    %6 = tosa.minimum %4, %3 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %7 = tosa.rsqrt %6 : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %8 = tosa.log %7 : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %9 = tosa.reverse %8 {axis = 0 : i32} : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %10 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %11 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %12 = tosa.negate %9, %10, %11 : (tensor<10x2x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<10x2x1xf32>
    %c2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<10x2x1xf32>}> : () -> tensor<10x2x1xf32>
    %t2 = tosa.maximum %12, %c2 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %c3 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<10x2x1xf32>}> : () -> tensor<10x2x1xf32>
    %t3 = tosa.maximum %7, %c3 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %13 = tosa.pow %t2, %t3 : (tensor<10x2x1xf32>, tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %14 = tosa.exp %13 : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %15 = tosa.log %14 : (tensor<10x2x1xf32>) -> tensor<10x2x1xf32>
    %16 = tosa.reduce_product %5 {axis = 2 : i32} : (tensor<2x3x2xi16>) -> tensor<2x3x1xi16>
    %17 = tosa.argmax %15 {axis = 1 : i32} : (tensor<10x2x1xf32>) -> tensor<10x1xi32>
    %18 = tosa.reduce_sum %16 {axis = 1 : i32} : (tensor<2x3x1xi16>) -> tensor<2x1x1xi16>
    %cast = tensor.cast %17 : tensor<10x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %18 : tensor<2x1x1xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}