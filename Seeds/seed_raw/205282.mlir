module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-40> : tensor<7xi16>}> : () -> tensor<7xi16>
    %1 = "tosa.const"() <{values = dense<-9.061000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.clz %0 : (tensor<7xi16>) -> tensor<7xi16>
    %3 = tosa.bitwise_not %2 : (tensor<7xi16>) -> tensor<7xi16>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<7xi16>) -> tensor<i32>
    %5 = tosa.abs %4 : (tensor<i32>) -> tensor<i32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = tosa.negate %5, %6, %7 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %9 = tosa.bitwise_or %8, %5 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.tanh %1 : (tensor<f32>) -> tensor<f32>
    %11 = tosa.reverse %2 {axis = 0 : i32} : (tensor<7xi16>) -> tensor<7xi16>
    %12 = tosa.bitwise_not %9 : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<7xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %12 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

