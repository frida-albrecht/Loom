module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<4> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<198> : tensor<6x1x3x9xi64>}> : () -> tensor<6x1x3x9xi64>
    %3 = "tosa.const"() <{values = dense<111> : tensor<77x1x3x9xi64>}> : () -> tensor<77x1x3x9xi64>
    %4 = "tosa.const"() <{values = dense<-1.045400e+02> : tensor<3x10x7x6xf32>}> : () -> tensor<3x10x7x6xf32>
    %5 = "tosa.const"() <{values = dense<2.759000e+01> : tensor<1x10x7x1xf32>}> : () -> tensor<1x10x7x1xf32>
    %6 = tosa.sub %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %7 = tosa.concat %2, %3 {axis = 0 : i32} : (tensor<6x1x3x9xi64>, tensor<77x1x3x9xi64>) -> tensor<83x1x3x9xi64>
    %8 = tosa.bitwise_xor %7, %7 : (tensor<83x1x3x9xi64>, tensor<83x1x3x9xi64>) -> tensor<83x1x3x9xi64>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<3x10x7x6xf32>}> : () -> tensor<3x10x7x6xf32>
    %t0 = tosa.maximum %4, %c0 : (tensor<3x10x7x6xf32>, tensor<3x10x7x6xf32>) -> tensor<3x10x7x6xf32>
    %9 = tosa.pow %t0, %5 : (tensor<3x10x7x6xf32>, tensor<1x10x7x1xf32>) -> tensor<3x10x7x6xf32>
    %10 = tosa.argmax %9 {axis = 0 : i32} : (tensor<3x10x7x6xf32>) -> tensor<10x7x6xi32>
    %11 = tosa.add %8, %7 : (tensor<83x1x3x9xi64>, tensor<83x1x3x9xi64>) -> tensor<83x1x3x9xi64>
    %12 = tosa.floor %9 : (tensor<3x10x7x6xf32>) -> tensor<3x10x7x6xf32>
    %cast = tensor.cast %6 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %10 : tensor<10x7x6xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %11 : tensor<83x1x3x9xi64> to tensor<*xi64>
    %cast_2 = tensor.cast %12 : tensor<3x10x7x6xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}