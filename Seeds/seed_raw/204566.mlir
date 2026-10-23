module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-158> : tensor<3x8x1x6xi16>}> : () -> tensor<3x8x1x6xi16>
    %1 = "tosa.const"() <{values = dense<154> : tensor<6x4x7xi64>}> : () -> tensor<6x4x7xi64>
    %2 = "tosa.const"() <{values = dense<-3> : tensor<1x1x7xi64>}> : () -> tensor<1x1x7xi64>
    %3 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<3x8x1x6xi16>) -> tensor<3x8x1x6xi16>
    %4 = tosa.minimum %1, %2 : (tensor<6x4x7xi64>, tensor<1x1x7xi64>) -> tensor<6x4x7xi64>
    %5 = tosa.abs %3 : (tensor<3x8x1x6xi16>) -> tensor<3x8x1x6xi16>
    %6 = tosa.logical_right_shift %4, %4 : (tensor<6x4x7xi64>, tensor<6x4x7xi64>) -> tensor<6x4x7xi64>
    %7 = tosa.bitwise_or %5, %3 : (tensor<3x8x1x6xi16>, tensor<3x8x1x6xi16>) -> tensor<3x8x1x6xi16>
    %8 = tosa.clamp %6 {max_val = 63 : i64, min_val = 15 : i64} : (tensor<6x4x7xi64>) -> tensor<6x4x7xi64>
    %cast = tensor.cast %7 : tensor<3x8x1x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<6x4x7xi64> to tensor<*xi64>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

